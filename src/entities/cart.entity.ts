import {
  Column,
  Entity,
  OneToMany,
  OneToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CartArticle } from "./cart-article.entity";
import { Order } from "./order.entity";


@Entity("cart", { schema: "aplikacija" })
export class Cart {
  @PrimaryGeneratedColumn({ type: "int", name: "cart_id", unsigned: true })
  cartId: number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @OneToMany(() => CartArticle, (cartArticle) => cartArticle.cart)
  cartArticles: CartArticle[];

  @OneToOne(() => Order, (order) => order.cart)
  order: Order;
}
