import { Controller } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Category } from "entities/category.entity";
import { CategoryService } from "src/services/category/category.service";

@Controller('api/category')

/* Zelimo da imamo krud operacije za model podataka koji je definisan tipoom
koji je propisan u Category definiciji
*/
@Crud({
    model: {
        type: Category
    },
    // polje koje koristimo je id, field koji se koristi je id, dodajemo "primary", da bi identifikovali da je id primarni kljuc
    params: {
        id: {
            field: 'categoryId',
            type: 'number',
            primary: true
        }
    },

    

    query: {

        join: {
            features: {
                eager: true
            },
            articles: {
                eager: false
            }
        }
    }
})
// kada napravimo novi kontroler, moramo ga dodati u app.module.ts
export class CategoryController {

    constructor(public service: CategoryService) { }

}