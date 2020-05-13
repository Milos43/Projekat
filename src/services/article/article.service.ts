import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Article } from "entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { ArticleFeature } from "entities/article-feature.entity";

@Injectable()
export class ArticleService extends TypeOrmCrudService<Article>{


    constructor(
        @InjectRepository(Article)
        private readonly article: Repository<Article>,

        @InjectRepository(ArticleFeature)
        private readonly articleFeature: Repository<ArticleFeature>

    ) {

        super(article);
    }



    async createFullArticle(data: AddArticleDto): Promise<Article | ApiResponse> {

        let newArticle: Article = new Article();

        newArticle.name = data.name;
        newArticle.categoryId = data.categoryId;
        newArticle.shortDescription = data.shortDescription;
        newArticle.description = data.description;
        newArticle.manufacturerId = data.manufacturerId;
        newArticle.materialId = data.materialId;
        newArticle.price = data.price;

        let savedArticle = await this.article.save(newArticle);


        for (let feature of data.features) {
            let newArticleFeature: ArticleFeature = new ArticleFeature();
            newArticleFeature.articleId = savedArticle.articleId;
            newArticleFeature.featureId = feature.featureId;
            newArticleFeature.value = feature.value;

            await this.articleFeature.save(newArticleFeature);

        }

        return await this.article.findOne(savedArticle.articleId, {
            relations: [
                "category",
                "articleFeatures",
                "features",
                "manufacturer",
                "material"

            ]
        });
    }
}