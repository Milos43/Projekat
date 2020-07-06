import { Injectable } from "@nestjs/common";
import { Order } from "src/entities/order.entity";
import { MailerService } from "@nestjs-modules/mailer";
import { MailConfig } from "config/mail.config";
import { CartArticle } from "src/entities/cart-article.entity";

@Injectable()
export class OrderMailer {
    constructor(private readonly mailService: MailerService) { }

    async sendOrderEmail(order: Order) {
       
            await this.mailService.sendMail({
                to: order.email,
                bcc: MailConfig.orderNotificationMail,
                subject: 'Order details',
                encoding: 'UTF-8',
                html: this.makeOrderHtml(order),
            });
            

    }
    private makeOrderHtml(order: Order): string {
        let suma = order.cart.cartArticles.reduce((sum, current: CartArticle) => {
            return sum +
                current.quantity *
                Number(current.article.price)
        }, 0);

        return `<p>Zahvaljujemo se za vasu porudzbinu</p>
        <p>Ovo su detalji vase porudzbine: </p>
        <ul>
        ${order.cart.cartArticles.map((cartArticle: CartArticle) => {
            return `<li>
            ${cartArticle.article.name} x 
            ${cartArticle.quantity}
            </li>`
        }).join("")}
        </ul>
        <p>Ukupan iznos je: ${suma.toFixed(2)} RSD</p>
        <p>Potpis...</p>`;

    }
}
