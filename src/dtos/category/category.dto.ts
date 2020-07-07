import * as Validator from 'class-validator';

export class CategoryDto {
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(3, 128)
    name: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(5, 128)
    imagePath: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(5, 1000)
    description: string;

}