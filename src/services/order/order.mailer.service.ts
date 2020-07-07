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
        <br/>
        <p>Ovo su detalji vase porudzbine: </p>
        <br/>
        <ul>
        ${order.cart.cartArticles.map((cartArticle: CartArticle) => {
            return `<li>
            ${cartArticle.article.name} x 
            ${cartArticle.quantity}
            </li>`
        }).join("")}
        </ul>
        <br/>
        <p>Ukupan iznos je: <b>${suma.toFixed(2)} </b>RSD</p>
        <br/>
        <p><b>Podaci za slanje:</b></p>
        <br/>
        <p><b>Ime:</b> ${order.name}</p>
        <p><b>Prezime:</b> ${order.surname}</p>
        <p><b>Adresa:</b> ${order.address}</p>
        <br/>
        <p>Srdačan pozdrav`;

    }
}
