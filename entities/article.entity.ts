import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  ManyToMany,
  JoinTable,
} from "typeorm";
import { Category } from "./category.entity";
import { ArticleFeature } from "./article-feature.entity";
import { Manufacturer } from "./manufacturer.entity";
import { Material } from "./material.entity";
import { CartArticle } from "./cart-article.entity";
import { Photo } from "./photo.entity";
import { type } from "os";
import { Feature } from "./feature.entity";

@Index("fk_article_category_id", ["categoryId"], {})
@Index("fk_article_manufacturer_id", ["manufacturerId"], {})
@Index("fk_article_material_id", ["materialId"], {})
@Entity("article")
export class Article {
  @PrimaryGeneratedColumn({ type: "int", name: "article_id", unsigned: true })
  articleId: number;

  @Column("varchar", { name: "name", length: 128, default: () => "'0'" })
  name: string;

  @Column("text", { name: "description" })
  description: string;

  @Column("int", {
    name: "manufacturer_id",
    unsigned: true,
    default: () => "'0'",
  })
  manufacturerId: number;

  @Column("int", { name: "category_id", unsigned: true, default: () => "'0'" })
  categoryId: number;

  @Column("varchar", {
    name: "short_description",
    length: 255,
    default: () => "'0'",
  })
  shortDescription: string;

  @Column("int", { name: "material_id", unsigned: true, default: () => "'0'" })
  materialId: number;

  @Column("decimal", {
    name: "price",
    unsigned: true,
    precision: 10,
    scale: 2,
    default: () => "'0.00'",
  })
  price: Number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @ManyToOne(() => Category, (category) => category.articles, {
    onDelete: "NO ACTION",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(() => ArticleFeature, (articleFeature) => articleFeature.article)
  articleFeatures: ArticleFeature[];





  //pravimo relaciju many to many
  @ManyToMany(type => Feature, feature => feature.article)
  @JoinTable({
    name: "article_feature",
    joinColumn: { name: "article_id", referencedColumnName: "articleId" },
    inverseJoinColumn: { name: "feature_id", referencedColumnName: "featureId" }
  })
  features: Feature[];





  @ManyToOne(() => Manufacturer, (manufacturer) => manufacturer.articles, {
    onDelete: "NO ACTION",
    onUpdate: "CASCADE",
  })
  @JoinColumn([
    { name: "manufacturer_id", referencedColumnName: "manufacturerId" },
  ])
  manufacturer: Manufacturer;

  @ManyToOne(() => Material, (material) => material.articles, {
    onDelete: "NO ACTION",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "material_id", referencedColumnName: "materialId" }])
  material: Material;

  @OneToMany(() => CartArticle, (cartArticle) => cartArticle.article)
  cartArticles: CartArticle[];

  @OneToMany(() => Photo, (photo) => photo.article)
  photos: Photo[];
}
