import { Module, NestModule, MiddlewareConsumer, RequestMethod } from '@nestjs/common';
import { AppController } from './controllers/app.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuration';
import { Administrator } from 'src/entities/administrator.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { ArticleFeature } from 'src/entities/article-feature.entity';
import { Article } from 'src/entities/article.entity';
import { CartArticle } from 'src/entities/cart-article.entity';
import { Cart } from 'src/entities/cart.entity';
import { Category } from 'src/entities/category.entity';
import { Feature } from 'src/entities/feature.entity';
import { Order } from 'src/entities/order.entity';
import { Photo } from 'src/entities/photo.entity';
import { AdministratorController } from './controllers/api/administrator.controller';
import { CategoryController } from './controllers/api/category.controller';
import { CategoryService } from './services/category/category.service';
import { ArticleService } from './services/article/article.service';
import { ArticleController } from './controllers/api/article.controller';
import { AuthController } from './controllers/api/auth.controller';
import { AuthMiddleware } from './middlewares/auth.middleware';
import { PhotoService } from './services/photo/photo.service';
import { FeatureService } from './services/feature/feature.service';
import { FeatureController } from './controllers/api/feature.controller';
import { AdministratorToken } from './entities/administrator-token.entity';
import { ApiCartController } from './controllers/api/cart.controller';
import { CartService } from './services/cart/cart.service';
import { OrderService } from './services/order/order.service';
import { MailerModule } from '@nestjs-modules/mailer';
import { MailConfig } from 'config/mail.config';
import { OrderMailer } from './services/order/order.mailer.service';


@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: DatabaseConfiguration.hostname,
      port: 3306,
      username: DatabaseConfiguration.username,
      password: DatabaseConfiguration.password,
      database: DatabaseConfiguration.database,
      entities: [
        Administrator,
        ArticleFeature,
        Article,
        CartArticle,
        Cart,
        Category,
        Feature,
        Order,
        Photo,
        AdministratorToken
      ]
    }),

    // repozitorijumi
    TypeOrmModule.forFeature([
      Administrator,
      ArticleFeature,
      Article,
      CartArticle,
      Cart,
      Category,
      Feature,
      Order,
      Photo,
      AdministratorToken
    ]),
    MailerModule.forRoot({
      transport: 'smtps://' + MailConfig.username + ':' +
        MailConfig.password + '@' +
        MailConfig.hostname,
      defaults: {
        from: MailConfig.senderEmail,
      },
    }),
  ],
  controllers: [
    AppController,
    AdministratorController,
    CategoryController,
    ArticleController,
    AuthController,
    FeatureController,
    ApiCartController
  ],
  providers: [
    AdministratorService,
    CategoryService,
    ArticleService,
    PhotoService,
    FeatureService,
    CartService,
    OrderService,
    OrderMailer,
  ],

  exports: [
    AdministratorService // export-ujemo administrator servis, da bi bio dostupan i van tog modula
    // auth middleware koristi AdministratorService, sto znaci da admin servis mora biti stavljen kao exportovani resurs
  ]
})

/*
Nest modul interfejs zahteva da imamo implementaciju nekog odredjenog metoda,
taj metod se zove "configure". Automatski ga importujemo

Consumer treba da primeni oredjeni middleware
*/
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {

    consumer
      .apply(AuthMiddleware) // primeni, da li postoji middleware za proveru da li postoji token
      // sve sto je u "auth" ruti treba da bude ignorisano, jer kada bi trazili token za login, nikada ga nebi dobili
      .exclude('auth/*', 'api/article/search*', 'cart/*',)
      .forRoutes(
        'api/administrator/*',
        { path: 'api/category*', method: RequestMethod.POST },
        { path: 'api/category*', method: RequestMethod.PATCH },
        { path: 'api/feature*', method: RequestMethod.POST },
        { path: 'api/feature*', method: RequestMethod.PATCH },
        { path: 'api/article/createFull/*', method: RequestMethod.POST },
        { path: 'api/article/createFull/*', method: RequestMethod.PATCH }, // ovo je ono sto hocemo da include-ujemo, obavezno koriscenje tokena
      )
  }
}
