import { Controller } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { ArticleService } from "src/services/article/article.service";
import { Article } from "entities/article.entity";

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

}