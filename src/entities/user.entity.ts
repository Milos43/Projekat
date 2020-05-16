import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Cart } from "./cart.entity";

@Entity("user")
export class User {
  @PrimaryGeneratedColumn({ type: "int", name: "user_id", unsigned: true })
  userId: number;

  @Column("varchar", { name: "email", length: 255, default: () => "'0'" })
  email: string;

  @Column("varchar", { name: "forename", length: 64, default: () => "'0'" })
  forename: string;

  @Column("varchar", { name: "surname", length: 64, default: () => "'0'" })
  surname: string;

  @Column("text", { name: "postal_address" })
  postalAddress: string;

  @OneToMany(() => Cart, (cart) => cart.user)
  carts: Cart[];
}
