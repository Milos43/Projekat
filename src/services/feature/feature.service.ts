import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Feature } from "src/entities/feature.entity";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";

@Injectable()
export class FeatureService extends TypeOrmCrudService<Feature>{

    /*
    Konstruktor kome je injectovan repozitorijum feature, prosledjen super konstruktoru extendovane klase (TypeOrmCrudService)
    */
    constructor(@InjectRepository(Feature) private readonly feature: Repository<Feature>) { //Kada pomenemo neki repozitorijum, moramo ga evidentirati u osnovnom (app) modulu

        super(feature);
    }
}