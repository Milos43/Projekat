import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  JoinTable,
  ManyToMany,
} from "typeorm";
import { ArticleFeature } from "./article-feature.entity";
import { Category } from "./category.entity";
import { Article } from "./article.entity";
import * as Validator from 'class-validator';

@Index("uq_feature_name_category_id", ["name", "categoryId"], { unique: true })
@Index("fk_feature_category_id", ["categoryId"], {})
@Entity("feature", { schema: "aplikacija" })
export class Feature {
  @PrimaryGeneratedColumn({ type: "int", name: "feature_id", unsigned: true })
  featureId: number;

  @Column("varchar", { name: "name", length: 32 })
  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(5, 32)
  name: string;

  @Column("int", { name: "category_id", unsigned: true, default: () => "'0'" })
  categoryId: number;

  @OneToMany(
    () => ArticleFeature,
    articleFeature => articleFeature.feature
  )
  articleFeatures: ArticleFeature[];



  // pravimo relaciju many to many, ovo je inverzno u odnosu na article.entity.ts
  @ManyToMany(type => Article, article => article.features)
  @JoinTable({
    name: "article_feature",
    joinColumn: { name: "feature_id", referencedColumnName: "featureId" },
    inverseJoinColumn: { name: "article_id", referencedColumnName: "articleId" }
  })
  articles: Article[];




  @ManyToOne(
    () => Category,
    category => category.features,
    { onDelete: "NO ACTION", onUpdate: "CASCADE", }
  )
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;
}
