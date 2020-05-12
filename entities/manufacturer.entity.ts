import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./article.entity";

@Index("uq_manufacturer_name", ["name"], { unique: true })
@Entity("manufacturer", { schema: "aplikacija" })
export class Manufacturer {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "manufacturer_id",
    unsigned: true,
  })
  manufacturerId: number;

  @Column("varchar", {
    name: "name",
    unique: true,
    length: 32,
    default: () => "'0'",
  })
  name: string;

  @OneToMany(() => Article, (article) => article.manufacturer)
  articles: Article[];
}
