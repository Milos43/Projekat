import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Administrator } from 'entities/administrator.entity';
import { Repository } from 'typeorm';
import { AddAdministratorDto } from 'src/dtos/administrator/add.administrator.dto';
import * as crypto from "crypto";
import { EditAdministratorDto } from 'src/dtos/edit.administrator.dto';

@Injectable()
export class AdministratorService {
    constructor(
        @InjectRepository(Administrator)
        private readonly administrator: Repository<Administrator>
    ) { }

    getAll(): Promise<Administrator[]> {

        return this.administrator.find();
    }

    getById(id: number): Promise<Administrator> {

        return this.administrator.findOne(id);
    }

    /* add() Prihvata sve podatke koji su potrebni da se napravi novi
    zapis u bazi*/

    add(data: AddAdministratorDto): Promise<Administrator> {

        //Pravimo transformaciju iz DTO u Model
        //username prelazi u username
        //password prelazi u password hash (SHA 512)

        const crypto = require('crypto');

        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);

        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        // napravili smo novi primerak admina da bi ga save-ovali

        let newAdmin: Administrator = new Administrator();
        newAdmin.username = data.username;
        newAdmin.passwordHash = passwordHashString;


        return this.administrator.save(newAdmin);

    }

    async editById(id: number, data: EditAdministratorDto): Promise<Administrator> {
        let admin: Administrator = await this.administrator.findOne(id);

        const crypto = require('crypto');
        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);
        const passwordHashString = passwordHash.digest('hex').toUpperCase();


        admin.passwordHash = passwordHashString;

        return this.administrator.save(admin);

    }
}
