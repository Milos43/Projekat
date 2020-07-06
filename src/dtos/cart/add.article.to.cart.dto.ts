import * as Validator from 'class-validator';

export class AddArticleToCartDto {
  articleId: number;

  @Validator.IsPositive()
  @Validator.IsNotEmpty()
  @Validator.IsNumber({
    allowInfinity: false,
    allowNaN: false,
    maxDecimalPlaces: 0
  })
  quantity: number;
}