import * as Validator from 'class-validator';
import { ArticleFeatureComponentDto } from './article.feature.component.dto';



export class AddArticleDto {
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(5, 128)
    name: string;

    categoryId: number;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(10, 255)
    shortDescription: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(64, 10000)
    description: string;

    @Validator.IsNotEmpty()
    @Validator.IsPositive()
    @Validator.IsNumber()
    price: number;

    manufacturerId: number;
    materialId: number;

    @Validator.IsArray()
    @Validator.ValidateNested({
        always: true // svi objekti u nizu objekta treba da budu validirani
    })
    features: ArticleFeatureComponentDto[];
}