import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Injectable } from "@nestjs/common";
import { Photo } from "src/entities/photo.entity";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";

@Injectable()
export class PhotoService extends TypeOrmCrudService<Photo>{

    constructor(
        @InjectRepository(Photo)
        private readonly photo: Repository<Photo>) {

        super(photo);

    }

    add(newPhoto: Photo): Promise<Photo> {
        return this.photo.save(newPhoto);
    }

    /* 
    "deleteByID" je funkcija uzima ID fotografije koju servis zahteva da obrisemo,
    prosledice repozitorijumu zahtev za brisanje fotografije tog ID-a,
    sacekace ishod (await) i onda ce vratiti rezultat
    */
    async deleteById(id: number){
        return await this.photo.delete(id);
    }
}
