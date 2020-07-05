import { Controller, Get, Param } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { Feature } from "src/entities/feature.entity";
import { FeatureService } from "src/services/feature/feature.service";
import DistinctFeatureValuesDto from "src/dtos/feature/distinct.feature.values.dto";

@Controller('api/feature')

/* Zelimo da imamo krud operacije za model podataka koji je definisan tipoom
koji je propisan u Feature definiciji
*/
@Crud({
    model: {
        type: Feature
    },
    // polje koje koristimo je id, field koji se koristi je id, dodajemo "primary", da bi identifikovali da je id primarni kljuc
    params: {
        id: {
            field: 'featureId',
            type: 'number',
            primary: true
        }
    },



    query: {

        join: {
            articleFeatures: {
                eager: false
            },
            category: {
                eager: true
            },
            articles: {
                eager: false
            }
        }
    }
})
// kada napravimo novi kontroler, moramo ga dodati u app.module.ts
export class FeatureController {

    constructor(public service: FeatureService) { }

    @Get('values/:categoryId')
    async getDistinctValuesByCategoryId(@Param('categoryId') categoryId: number): Promise<DistinctFeatureValuesDto> {
        return await this.service.getDistinctValuesByCategoryId(categoryId);
    }
}