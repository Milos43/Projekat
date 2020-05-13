import { Controller, Post, Body } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { ArticleService } from "src/services/article/article.service";
import { Article } from "entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";

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

    constructor(public service: ArticleService) { }

    @Post('createFull') // POST http://localhost:3000/api/article/createFull/
    createFullArticle(@Body() data: AddArticleDto) {

        return this.service.createFullArticle(data);

    }

}