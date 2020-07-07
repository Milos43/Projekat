import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Category } from "src/entities/category.entity";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { CategoryDto } from "src/dtos/category/category.dto";
import { ApiResponse } from "src/misc/api.response.class";

@Injectable()
export class CategoryService extends TypeOrmCrudService<Category>{

    /*
    Konstruktor kome je injectovan repozitorijum category, prosledjen super konstruktoru extendovane klase (TypeOrmCrudService)
    */
    constructor(@InjectRepository(Category) private readonly category: Repository<Category>) { //Kada pomenemo neki repozitorijum, moramo ga evidentirati u osnovnom (app) modulu

        super(category);
    }

    async createFullCategory(data: CategoryDto): Promise<Category | ApiResponse> {
        let newCategory: Category = new Category();

        newCategory.name = data.name;
        newCategory.imagePath = data.imagePath;
        newCategory.description = data.description;

        let savedCategory = await this.category.save(newCategory);

        return await this.category.findOne(savedCategory.categoryId);
    }

    async editById(id:number, data: CategoryDto) {

        const existingCategory: Category = await this.category.findOne(id);
        if(!existingCategory) {
            return new ApiResponse('error', -3001, 'Category not found!');
        }

        existingCategory.name = data.name;
        existingCategory.imagePath = data.imagePath;
        existingCategory.description = data.description;

        const savedCategory: Category = await this.category.save(existingCategory);
        if(!savedCategory) {
            return new ApiResponse('error', -3002, 'Cant save category! ');
        }
    }
}