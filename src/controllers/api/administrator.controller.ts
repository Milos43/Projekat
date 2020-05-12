import { Controller, Get, Param, Put, Body, Post } from "@nestjs/common";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { Administrator } from "entities/administrator.entity";
import { AddAdministratorDto } from "src/dtos/administrator/add.administrator.dto";
import { EditAdministratorDto } from "src/dtos/edit.administrator.dto";

@Controller('api/administrator')
export class AdministratorController {

    constructor(
        private administratorService: AdministratorService
    ) { }


    /*
    Nije potrebno da putanja bude api/administrator, jer je api/administrator
     prefiks. Tako da ce sve metode automatski imati to kao svoj prefiks
    */

    @Get() // http://localhost:3000/api/administrator/
    getAll(): Promise<Administrator[]> {
        return this.administratorService.getAll();
    }

    @Get(':id') // http://localhost:3000/api/administrator/4/
    getById(@Param('id') administratorId: number): Promise<Administrator> {
        return this.administratorService.getById(administratorId);
    }

    /*Put metod se koristi kod dodavanja novih zapisa
    http://localhost:3000/api/administrator/
    */
    @Put()

    /* "Add" radi nesto sa sadrzajem koji mu se dostavi.
    Sadrzaj koji mu se dostavi, treba da bude iz tela
    http zahteva
    */

    /* Da bismo koristili nesto iz tela zahteva, koristimo
    anotaciju @Body
    */

    /* Tip podataka koji ocekujemo da su u telu put zahteva,
    je takav da odgovara klasi koja se zove AddAdministratorDto
    */

    add(@Body() data: AddAdministratorDto): Promise<Administrator> {

        return this.administratorService.add(data);

    }

    //Ovo znaci da hocu da izmenim admina sa ID-em 4
    // POST http://localhost:3000/api/administrator/4/

    @Post(':id')
    edit(@Param('id') id: number, @Body() data: EditAdministratorDto): Promise<Administrator> {
        return this.administratorService.editById(id, data);
    }

}