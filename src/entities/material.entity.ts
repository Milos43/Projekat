import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Article } from "./article.entity";

@Index("name", ["name"], { unique: true })
@Entity("material", { schema: "aplikacija" })
export class Material {
  @PrimaryGeneratedColumn({ type: "int", name: "material_id", unsigned: true })
  materialId: number;

  @Column("varchar", {
    name: "name",
    unique: true,
    length: 50,
    default: () => "'0'",
  })
  name: string;

  @OneToMany(() => Article, (article) => article.material)
  articles: Article[];
}
