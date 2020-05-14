import { NestMiddleware, HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { Request, NextFunction, Response } from "express";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as jwt from 'jsonwebtoken';
import { JwtDataAdministratorDto } from "src/dtos/administrator/jwt.data.administrator.dto";
import { jwtSecret } from "config/jwt.secret";

@Injectable() // middleware se injectuje u ".apply" funkciju
export class AuthMiddleware implements NestMiddleware {
    constructor(private readonly administratorService: AdministratorService) { }

    async use(req: Request, res: Response, next: NextFunction) {

        // provera da li moze da se dopremi informacija da je authorization token dat
        if (!req.headers.authorization) {
            throw new HttpException('Token not found', HttpStatus.UNAUTHORIZED);
        }

        // provera da li token moze da se dekodira
        const token = req.headers.authorization;

        // u postman-u imamo "barer razmak pa token" mi taj razmak moramo da preskocimo, tome sluzi ovaj kod
        const tokenParts = token.split(' '); // razdvajamo token oko simbola "razmak"
        if (tokenParts.length !== 2){
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        const tokenString = tokenParts[1]; // iz tokenParts, uzimamo drugi po redu

        const jwtData: JwtDataAdministratorDto = jwt.verify(tokenString, jwtSecret);

        if (!jwtData) {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        // provera da li se poklapa IP adresa
        if (jwtData.ip !== req.ip.toString()) {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        /*
        ako se headers.useragent ne poklapa sa onim koji imamo upisan u 
        jwt objektu, izbacujemo gresku da je "bad token"
        */
        // provera da li se poklapa user-agent
        if (jwtData.ua !== req.headers["user-agent"]) {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        // provera da li korisnik postoji
        const administrator = await this.administratorService.getById(jwtData.administratorId);
        if (!administrator) {
            throw new HttpException('Administrator not found', HttpStatus.UNAUTHORIZED);
        }


        // proveravamo da li je istekao token - nas token vazi 14 dana

        const tranutniTimestamp = new Date().getTime() / 1000;

        /*
        ako je datumn isteka manji od trenutnog timestamp-a
        znaci da je u proslosti, ako je u proslosti znaci da imamo
        istekli token i dajemo status UNAUTHORIZED
        */
        if (tranutniTimestamp >= jwtData.ext) {
            throw new HttpException('The token has expired', HttpStatus.UNAUTHORIZED)
        }

        /*
        Kada nismo utvrdili da je razlog za prekid istek tokena,
        nepostojeci korisnik, nepoklapajuci user-agent, nepoklapajuca
        IP adresa, nemogucnost dekodiranje tokena, nemogucnost dopremanja
        informacije da je authorization token u opste dat.
        Kada nista od toga nije dalo za razlog da se nas zahtev prekine,
        mi kazemo next()

        Ovim procesom proveravamo token. Da li AuthMiddleware treba da
        presretne i prekine izvrsavanje nasih daljih metoda ili ne
        */
        next();
    }

}