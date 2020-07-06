import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Cart } from "src/entities/cart.entity";
import { CartArticle } from "src/entities/cart-article.entity";
import { Article } from "src/entities/article.entity";
import { ApiResponse } from "src/misc/api.response.class";

@Injectable()
export class CartService {
    constructor(@InjectRepository(Cart) private readonly cart: Repository<Cart>,
        @InjectRepository(CartArticle) private readonly cartArticle: Repository<CartArticle>,
        @InjectRepository(Article) private readonly article: Repository<Article>,
    ) { }

    async getLastActiveCartByCartId(cartId: number): Promise<Cart | null> {

        const carts = await this.cart.find({
            order: {
                createdAt: "DESC",
            },
            take: 1,
            relations: ["order"],
        });

        if (!carts || carts.length === 0) {
            return null;
        }

        const cart = carts[0];

        if (cart.order !== null) {
            return null;
        }

        return cart;
    }

    async createNewCart(): Promise<Cart> {
        const newCart: Cart = new Cart();
        return await this.cart.save(newCart);
    }

    async addArticleToCart(cartId: number, articleId: number, quantity: number): Promise<Cart | ApiResponse> {
        let record: CartArticle = await this.cartArticle.findOne({
            cartId: cartId,
            articleId: articleId
        });

        const article = await this.article.findOne(articleId);
        if (!article) {
            return new ApiResponse("error", -6002, "There is no article");
        }

        if (!record) {
            record = new CartArticle();
            record.cartId = cartId;
            record.articleId = articleId;
            record.quantity = quantity;
        } else {
            record.quantity += quantity;
        }

        const savedCartArticle = await this.cartArticle.save(record);

        if (!savedCartArticle) {
            return new ApiResponse("error", -6001, "Can't add article to cart");
        }

        return await this.getById(cartId);
    }

    async getById(cartId: number): Promise<Cart> {

        return this.cart.findOne(cartId, {
            relations: [
                "cartArticles",
                "cartArticles.article",
                "cartArticles.article.category"
            ]
        })
    }

    async changeQuantity(cartId: number, articleId: number, newQuantity: number): Promise<Cart> {
        let record: CartArticle = await this.cartArticle.findOne({
            cartId: cartId,
            articleId: articleId
        });

        if (record) {

            record.quantity = newQuantity;

            if (record.quantity === 0) {
                await this.cartArticle.delete(record.cartArticleId);
            } else {
                await this.cartArticle.save(record);
            }
        }

        return await this.getById(cartId);
    }
}