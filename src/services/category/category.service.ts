import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Category } from "src/entities/category.entity";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";

@Injectable()
export class CategoryService extends TypeOrmCrudService<Category>{

    /*
    Konstruktor kome je injectovan repozitorijum category, prosledjen super konstruktoru extendovane klase (TypeOrmCrudService)
    */
    constructor(@InjectRepository(Category) private readonly category: Repository<Category>) { //Kada pomenemo neki repozitorijum, moramo ga evidentirati u osnovnom (app) modulu
       
        super(category);
    }
}