import { Controller, Post, Body, Patch, Param } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Category } from "src/entities/category.entity";
import { CategoryService } from "src/services/category/category.service";
import { CategoryDto } from "src/dtos/category/category.dto";

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
            },
            categorires: {
                eager: true
            }
        }
    }
})
// kada napravimo novi kontroler, moramo ga dodati u app.module.ts
export class CategoryController {

    constructor(public service: CategoryService) { }
    routes: {
        only: [
            "createOneBase",
            "createManyBase",
            "updateOneBase",
            "getManyBase",
            "getOneBase",
        ],
    }
    @Post()
    createFullCategory(@Body() data: CategoryDto) {
        return this.service.createFullCategory(data);
    }
    @Patch(':categoryId')
    async editById(@Param('categoryId') categoryId: number, @Body() data: CategoryDto) {
        return await this.service.editById(categoryId, data);
    }

}