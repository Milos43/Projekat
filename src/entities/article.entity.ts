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
import { CartArticle } from "./cart-article.entity";
import { Photo } from "./photo.entity";
import { Feature } from "./feature.entity";
import * as Validator from 'class-validator';

@Index("fk_article_category_id", ["categoryId"], {})
@Entity("article")
export class Article {
  @PrimaryGeneratedColumn({ type: "int", name: "article_id", unsigned: true })
  articleId: number;

  @Column("varchar", { name: "name", length: 128 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(5, 128)
  name: string;

  @Column("text", { name: "description" })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(10, 10000)
  description: string;

  @Column("int", { name: "category_id", unsigned: true })
  categoryId: number;

  @Column("varchar", {
    name: "short_description",
    length: 255
  })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(5, 255)
  shortDescription: string;

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

  @ManyToOne(() => Category, category => category.articles, {
    onDelete: "NO ACTION",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;

  @OneToMany(() => ArticleFeature, articleFeature => articleFeature.article)
  articleFeatures: ArticleFeature[];

  //pravimo relaciju many to many
  @ManyToMany(type => Feature, feature => feature.articles)
  @JoinTable({
    name: "article_feature",
    joinColumn: { name: "article_id", referencedColumnName: "articleId" },
    inverseJoinColumn: { name: "feature_id", referencedColumnName: "featureId" }
  })
  features: Feature[];

  @OneToMany(() => CartArticle, (cartArticle) => cartArticle.article)
  cartArticles: CartArticle[];

  @OneToMany(() => Photo, (photo) => photo.article)
  photos: Photo[];
}
