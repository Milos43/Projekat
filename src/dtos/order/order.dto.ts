import * as Validator from 'class-validator';

export class orderDto {

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2, 64)
    name: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2, 64)
    surname: string;

    @Validator.IsEmail({
        allow_ip_domain: false,
        allow_utf8_local_part: true,
        require_tld: true,
    })
    email: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2, 64)
    address: string;

}