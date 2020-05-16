//JWT je skracenica za JSON Web Token

export class JwtDataAdministratorDto {
    administratorId: number;
    username: string;
    exp: number; // UNIX TIMESTAMP
    ip: string;
    ua: string; // User Agent


    /*
    toPlainObject smo radili zato sto payload u auth.controller mora da
    bude "Plain" objekat. jwtData mora da bude plain object
    */

    toPlainObject() {
        return {
            administratorId: this.administratorId,
            username: this.username,
            exp: this.exp,
            ip: this.ip,
            ua: this.ua
        }
    }
}