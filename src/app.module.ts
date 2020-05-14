import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { AppController } from './controllers/app.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuration';
import { Administrator } from 'entities/administrator.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { ArticleFeature } from 'entities/article-feature.entity';
import { Article } from 'entities/article.entity';
import { CartArticle } from 'entities/cart-article.entity';
import { Cart } from 'entities/cart.entity';
import { Category } from 'entities/category.entity';
import { Feature } from 'entities/feature.entity';
import { Manufacturer } from 'entities/manufacturer.entity';
import { Material } from 'entities/material.entity';
import { Order } from 'entities/order.entity';
import { Photo } from 'entities/photo.entity';
import { User } from 'entities/user.entity';
import { AdministratorController } from './controllers/api/administrator.controller';
import { CategoryController } from './controllers/api/category.controller';
import { CategoryService } from './services/category/category.service';
import { ArticleService } from './services/article/article.service';
import { ArticleController } from './controllers/api/article.controller';
import { AuthController } from './controllers/api/auth.controller';
import { AuthMiddleware } from './middlewares/auth.middleware';



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
        Manufacturer,
        Material,
        Order,
        Photo,
        User
      ]
    }),

    // repozitorijumi
    TypeOrmModule.forFeature([
      Administrator,
      Category,
      Article,
      ArticleFeature
    ])
  ],
  controllers: [
    AppController,
    AdministratorController,
    CategoryController,
    ArticleController,
    AuthController
  ],
  providers: [
    AdministratorService,
    CategoryService,
    ArticleService
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
      .exclude('auth/*')
      .forRoutes('api/*') // ovo je ono sto hocemo da include-ujemo, obavezno koriscenje tokena

  }

}
