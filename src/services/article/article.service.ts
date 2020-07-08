import { Injectable } from "@nestjs/common";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository, In } from "typeorm";
import { Article } from "src/entities/article.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { ArticleFeature } from "src/entities/article-feature.entity";
import { EditArticleDto } from "src/dtos/article/edit.article.dto";
import { ArticleSearchDto } from "src/dtos/article/article.search.dto";

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
                "photos",
            ]
        });

    }

    async search(data: ArticleSearchDto): Promise<Article[] | ApiResponse> {
        const builder = await this.article.createQueryBuilder("article");

        
        builder.leftJoinAndSelect("article.articleFeatures", "af");
        builder.leftJoinAndSelect("article.features", "features");
        builder.leftJoinAndSelect("article.photos", "photos");


        builder.where('article.categoryId = :catId', { catId: data.categoryId });



        if (data.keywords && data.keywords.length > 0) {
            builder.andWhere(`(
                article.name LIKE :kw OR
                article.shortDescription LIKE :kw
                OR article.description LIKE :kw)`,
                { kw: '%' + data.keywords.trim() + '%' });
        }

        if (data.priceMin && typeof data.priceMin === 'number') {
            builder.andWhere('article.price >= :min', { min: data.priceMin });
        }

        if (data.priceMax && typeof data.priceMax === 'number') {
            builder.andWhere('article.price <= :max', { max: data.priceMax });
        }


        if (data.features && data.features.length > 0) {
            for (const feature of data.features) {
                builder.andWhere('af.featureId = :fId AND af.value IN (:fVals)',
                    {
                        fId: feature.featureId,
                        fVals: feature.values
                    });
            }
        }

        let orderBy = 'article.name';

        let orderDirection: 'ASC' | 'DESC' = 'ASC';

        if (data.orderBy) {
            orderBy = data.orderBy;

            if (orderBy === 'price') {
                orderBy = 'article.price';
            }

            if (orderBy === 'name') {
                orderBy = 'article.name';
            }

        }

        if (data.orderDirection) {
            orderDirection = data.orderDirection;
        }

        builder.orderBy(orderBy, orderDirection);

        let page = 0;
        let perPage: 5 | 10 | 25 | 50 | 75 = 25;

        if (data.page && typeof data.page === 'number') {
            page = data.page;
        }
        if (data.itemsPerPage && typeof data.itemsPerPage === 'number') {
            perPage = data.itemsPerPage;
        }

        builder.skip(page * perPage);
        builder.take(perPage)

        let articles = await builder.getMany();

        if (articles.length === 0) {
            return new ApiResponse("ok", 0, "No articles found");
        }
        return articles;
    }
}