import { Controller, Post, Body, Param, UseInterceptors, UploadedFile, Req } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { ArticleService } from "src/services/article/article.service";
import { Article } from "src/entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { FileInterceptor } from '@nestjs/platform-express';
import { StorageConfig } from "config/storage.config";
import { diskStorage } from "multer";
import { Photo } from "src/entities/photo.entity";
import { PhotoService } from "src/services/photo/photo.service";
import { ApiResponse } from "src/misc/api.response.class";
import * as fileType from 'file-type'
import * as fs from 'fs';
import * as sharp from 'sharp';


@Controller('api/article')

/* Zelimo da imamo krud operacije za model podataka koji je definisan tipoom
koji je propisan u Category definiciji
*/
@Crud({
    model: {
        type: Article
    },
    // polje koje koristimo je id, field koji se koristi je id, dodajemo "primary", da bi identifikovali da je id primarni kljuc
    params: {
        id: {
            field: 'articleId',
            type: 'number',
            primary: true
        }
    },



    query: {

        join: {
            category: {
                eager: true
            },
            photos: {
                eager: true
            },
            manufacturer: {
                eager: true
            },
            material: {
                eager: true
            },
            articleFeatures: {
                eager: true
            },
            features: {
                eager: true
            }
        }
    }
})
// kada napravimo novi kontroler, moramo ga dodati u app.module.ts
export class ArticleController {

    constructor(public service: ArticleService,
        public photoService: PhotoService) { }

    @Post('createFull') // POST http://localhost:3000/api/article/createFull/
    createFullArticle(@Body() data: AddArticleDto) {

        return this.service.createFullArticle(data);

    }

    @Post(':id/uploadPhoto/') // POST http://localhost:3000/api/article/:id/uploadPhoto/
    @UseInterceptors(
        FileInterceptor('photo', {
            storage: diskStorage({
                destination: StorageConfig.photo.destination,
                filename: (req, file, callback) => {
                    /*
                    Originalni naziv slike 'Neka  slike.jpg'
                    Mi taj naziv pretvaramo u 
                    '20200420-3268521585-Neka-slike.jpg'
                    prvi deo je datum, drugi deo je random string, a
                    treci deo je naziv gde su razmaci zamenjeni sa '-'.
                    Stavljamo random string, u slucaju da dva razlicita
                    korisnika uploaduju istu sliku sa istim nazivom
                    */
                    let original: string = file.originalname;

                    /*
                    ako se pojavi white space karakter (razmak) ili vise
                    takvih, globalno (na nivou celog stringa) zameniti
                    ga simbolom "-". Ako ne stavimo "g" da bude globalno,
                    samo bi prva belina bila zamenjena.
                    */
                    let normalized = original.replace(/\s+/g, '-');
                    normalized = normalized.replace(/[^A-z0-9\.\-]/g, '') // sve sto nije od velikog slova A do z, cifre od 0 do 9, simbol tacka, simbol minus. Globalno zameni praznim stringom

                    let sada = new Date();
                    let datePart = '';
                    datePart += sada.getFullYear().toString();
                    datePart += (sada.getMonth() + 1).toString(); // datum je vrednost od 0 do 11, zato smo stavili +1 da bi datum bio od 1 do 12
                    datePart += sada.getDate().toString();


                    let randomPart: string =
                        new Array(10)
                            .fill(0) // inicialno popunjavamo niz sa deset nula
                            .map(e => (Math.random() * 9).toFixed(0).toString())
                            .join(''); // joinujemo sve elemente bez razmaka

                    let fileName = datePart + '-' + randomPart + '-' + normalized;

                    fileName = fileName.toLocaleLowerCase();

                    callback(null, fileName);

                }

            }),

            // filtriramo fajlove koje dobijemo, kako korisnik nebi mogao da posalje bilo sta, nego samo sliku
            fileFilter: (req, file, callback) => {


                if (!file.originalname.toLowerCase().match(/\.(jpg||png)$/)) { // proveravamo ekstenziju
                    req.fileFilterError = 'Bad file extension!'
                    callback(null, false);
                    return;
                }



                if (!(file.mimetype.includes('jpeg') || file.mimetype.includes('png'))) { // proveravamo tip fajla
                    req.fileFilterError = 'Bad file content!'
                    callback(null, false);
                    return;
                }

                callback(null, true);

            },

            // limiti - 1 fajl i taj fajl je maximum 3MB
            limits: {
                files: 1,
                fileSize: StorageConfig.photo.maxSize
            }

        })
    )
    async uploadPhoto(
        @Param('id') articleId: number,
        @UploadedFile() photo,
        @Req() req): Promise<ApiResponse | Photo> {

        /* ove izuzetke pravimo da bi korisnik imao uvid u to gde je
           nastala greska. Jer u suprotnom, greska bi bila prikazana
           samo u konzoli servera, a korisniku bi bio prikazan error 500
        */
        if (req.fileFilterError) {
            return new ApiResponse('error', -4002, req.fileFilterError);
        }

        if (!photo) {
            return new ApiResponse('error', -4002, 'File not uploaded!');
        }

        // proveravamo da li je tip fajla onaj koji nam treba, brisemo ako nije
        const fileTypeResult = await fileType.fromFile(photo.path);
        if (!fileTypeResult) {

            fs.unlinkSync(photo.path); // brisanje

            return new ApiResponse('error', -4002, 'Cannot detect file type');
        }


        const realMimeType = fileTypeResult.mime;
        if (!(realMimeType.includes('jpeg') || realMimeType.includes('png'))) {

            fs.unlinkSync(photo.path); // brisanje

            return new ApiResponse('error', -4002, 'Bad file content type!');
        }




        await this.createResizedImage(photo, StorageConfig.photo.resize.thumb);
        await this.createResizedImage(photo, StorageConfig.photo.resize.small);



        const newPhoto: Photo = new Photo();
        newPhoto.articleId = articleId;
        newPhoto.imagePath = photo.filename;

        const savedPhoto = await this.photoService.add(newPhoto);
        if (!savedPhoto) {
            return new ApiResponse('error', -4001); // -4001 file upload je failovao
        }
        return savedPhoto;
    }




    async createResizedImage(photo, resizeSettings) {

        const originalFilePath = photo.path;
        const fileName = photo.filename;

        const destinationFilePath =
            StorageConfig.photo.destination +
            resizeSettings.directory +
            fileName;

        await sharp(originalFilePath)
            .resize({
                fit: 'cover',
                width: resizeSettings.width,
                height: resizeSettings.height,

            })
            .toFile(destinationFilePath);

    }
}