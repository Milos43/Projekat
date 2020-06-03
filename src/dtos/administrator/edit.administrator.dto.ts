//kod editovanja admina, dozvoljavamo da se izmeni samo password
import * as Validator from 'class-validator';

export class EditAdministratorDto {
    
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(6, 128)
    password: string;
}