import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Article } from "src/entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { ArticleFeature } from "src/entities/article-feature.entity";
import { EditArticleDto } from "src/dtos/article/edit.article.dto";

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

    async editFullArticle(articleId: number, data: EditArticleDto): Promise<Article | ApiResponse> {

        // primerak artikla koji u sebi sadrzi vrednost iz repozitorijuma artikla, kada uradimo findOne sa njenom articleId vrednoscu
        const existingArticle: Article = await this.article.findOne(articleId, {
            relations: ['articleFeatures'] // izvucemo postojeci artikal, ali ukljuci informaciju o articleFeature-ima
        });

        if (!existingArticle) {
            return new ApiResponse('error', -5001, 'Article not found!');
        }

        existingArticle.name = data.name;
        existingArticle.categoryId = data.categoryId;
        existingArticle.shortDescription = data.shortDescription;
        existingArticle.description = data.description;
        existingArticle.price = data.price;
        existingArticle.manufacturerId = data.manufacturerId;
        existingArticle.materialId = data.materialId;

        const savedArticle = await this.article.save(existingArticle);

        if (!savedArticle) {
            return new ApiResponse('error', -5002, 'Could not save new article data!');
        }

        if (data.features !== null) {

            // brisemo stare featur-e i dodajemo nove ponovo u bazu
            await this.articleFeature.remove(existingArticle.articleFeatures);  // delete zahteva da damo ID onoga sto se brise, remove zahteva objekat ili niz objekata onoga sto se brise

            for (let feature of data.features) {
                let newArticleFeature: ArticleFeature = new ArticleFeature();
                newArticleFeature.articleId = articleId;
                newArticleFeature.featureId = feature.featureId;
                newArticleFeature.value = feature.value;

                await this.articleFeature.save(newArticleFeature);

            }
        }

        // vracamo ceo artikal sa novim informacijama
        return await this.article.findOne(articleId, {
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