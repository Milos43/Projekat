import { Controller, Post, Body, Req } from "@nestjs/common";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { LoginAdministratorDto } from "src/dtos/administrator/login.administrator.dto";
import { ApiResponse } from "src/misc/api.response.class";
import * as jwt from 'jsonwebtoken';
import * as crypto from "crypto";
import { LoginInfoAdministratorDto } from "src/dtos/administrator/login.info.administrator.dto";
import { JwtDataAdministratorDto } from "src/dtos/administrator/jwt.data.administrator.dto";
import { Request } from "express";
import { jwtSecret } from "config/jwt.secret";


@Controller('auth')
export class AuthController {

    constructor(public administratorService: AdministratorService) { }


    /*
    Da bi dobili IP, pored @Body koji sadrzi informacije o DTO koji smo dobili,
    ukljucujemo i @Req() jer nam iz request-a treba informacija
    */

    @Post('login') // http://localhost:3000/auth/login/
    async doLogin(@Body() data: LoginAdministratorDto, @Req() req: Request): Promise<ApiResponse | LoginInfoAdministratorDto> {
        const administrator = await this.administratorService.getByUsername(data.username);

        // -3001 znaci da admin ne postoji
        if (!administrator) {
            return new Promise(resolve =>
                resolve(new ApiResponse('error', -3001)));
        }

        const passwordHash = crypto.createHash('sha512');
        passwordHash.update(data.password);
        const passwordHashString = passwordHash.digest('hex').toUpperCase();

        // -3002 adminova lozinka nije ispravna
        if (administrator.passwordHash !== passwordHashString) {
            return new Promise(resolve =>
                resolve(new ApiResponse('error', -3002)));
        }

        const jwtData = new JwtDataAdministratorDto();
        jwtData.administratorId = administrator.administratorId;
        jwtData.username = administrator.username;

        // "sada" -> trenutni datum
        let sada = new Date();
        sada.setDate(sada.getDate() + 14);

        /* "sada" konvertujemo u get.Time i taj time koji predstavlja broj
        milisekundi, delimo sa 1000 da bismo dobili broj sekundi, a to je unix timestamp
        */
        const istekTimestamp = sada.getTime() / 1000;

        jwtData.ext = istekTimestamp;

        jwtData.ip = req.ip.toString();
        jwtData.ua = req.headers["user-agent"];

        /* 
        sa jwtSecret smo potpisali token
        prvi argument jwt.sing-a je objekat koji zelimo da potpisemo, a drugi
        argument je secret- tajna informacija koju smo sacuvali u nasoj konfiguraciji
        jwt.secret.ts u config folderu
        */

        // jwtData je payload
        let token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

        const responseObject = new LoginInfoAdministratorDto(
            administrator.administratorId,
            administrator.username,
            token
        );

        return new Promise(resolve => resolve(responseObject));


    }
}