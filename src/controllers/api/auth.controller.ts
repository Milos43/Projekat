import { Controller, Post, Body, Req, HttpException, HttpStatus } from "@nestjs/common";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { LoginAdministratorDto } from "src/dtos/administrator/login.administrator.dto";
import { ApiResponse } from "src/misc/api.response.class";
import * as jwt from 'jsonwebtoken';
import * as crypto from "crypto";
import { LoginInfoAdministratorDto } from "src/dtos/administrator/login.info.administrator.dto";
import { JwtDataAdministratorDto } from "src/dtos/administrator/jwt.data.administrator.dto";
import { Request } from "express";
import { jwtSecret } from "config/jwt.secret";
import { JwtRefreshDataAdministratorDto } from "src/dtos/administrator/jwt.refresh.dto";
import { AdministratorRefreshTokenDto } from "src/dtos/administrator/administrator.refresh.token.dto";


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

        jwtData.exp = this.getDatePlus(60 * 5);

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


        const jwtRefreshDataAdministratorDto = new JwtRefreshDataAdministratorDto();
        jwtRefreshDataAdministratorDto.administratorId = jwtData.administratorId;
        jwtRefreshDataAdministratorDto.username = jwtData.username;
        jwtRefreshDataAdministratorDto.exp = this.getDatePlus(60 * 60 * 24 * 31); // ovoliko sekundi dodajemo na nas datum (31 dan) i to je nas expiery date
        jwtRefreshDataAdministratorDto.ip = jwtData.ip;
        jwtRefreshDataAdministratorDto.ua = jwtData.ua;

        let refreshToken: string = jwt.sign(jwtRefreshDataAdministratorDto.toPlainObject(), jwtSecret);

        const responseObject = new LoginInfoAdministratorDto(
            administrator.administratorId,
            administrator.username,
            token,
            refreshToken,
            this.getIsoDate(jwtRefreshDataAdministratorDto.exp)
        );

        await this.administratorService.addToken(
            administrator.administratorId,
            refreshToken,
            this.getDatabaseDateFormat(this.getIsoDate(jwtRefreshDataAdministratorDto.exp))
        );

        return new Promise(resolve => resolve(responseObject));

    }

    // mehanizam refreshovanja tokena

    @Post('administrator/refresh') // http://localhost:3000/auth/administrator/refresh
    async administratorTokenRefresh(@Req() req: Request, @Body() data: AdministratorRefreshTokenDto): Promise<LoginInfoAdministratorDto | ApiResponse> {
        const administratorToken = await this.administratorService.getAdministratorToken(data.token);

        if (!administratorToken) {
            return new ApiResponse("error", -10002, "No such refresh token!")
        }

        if (administratorToken.isValid === 0) {
            return new ApiResponse("error", -10003, "The token is no longer valid!")
        }

        const sada = new Date();
        const datumIsteka = new Date(administratorToken.expiresAt);

        if (datumIsteka.getTime() < sada.getTime()) {
            return new ApiResponse("error", -10003, "The token has expired!")
        }


        let jwtRefreshData: JwtRefreshDataAdministratorDto; // deklarisemo jwt data

        try {
            jwtRefreshData = jwt.verify(data.token, jwtSecret);
        } catch (e) {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        if (!jwtRefreshData) {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        if (jwtRefreshData.ip !== req.ip.toString()) {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        if (jwtRefreshData.ua !== req.headers["user-agent"]) {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        const jwtData = new JwtDataAdministratorDto();
        jwtData.administratorId = jwtRefreshData.administratorId;
        jwtData.username = jwtRefreshData.username;
        jwtData.exp = this.getDatePlus(60 * 5); // vreme trajanja tokena je 5 minuta
        jwtData.ip = jwtRefreshData.ip;
        jwtData.ua = jwtRefreshData.ua;

        let token: string = jwt.sign(jwtData.toPlainObject(), jwtSecret);

        const responseObject = new LoginInfoAdministratorDto(
            jwtData.administratorId,
            jwtData.username,
            token,
            data.token,
            this.getIsoDate(jwtRefreshData.exp)
        );

        return responseObject;
    }



    private getDatePlus(numberOfSeconds: number): number {
        return new Date().getTime() / 1000 + numberOfSeconds;
    }

    private getIsoDate(timestamp: number): string {
        const date = new Date();
        date.setTime(timestamp * 1000);
        return date.toISOString();
    }

    // moramo da prepravimo iso format datuma, tako da moze da se koristi u bazi podataka
    private getDatabaseDateFormat(isoFormat: string): string {
        return isoFormat.substr(0, 19).replace('T', ' ');
    }
}