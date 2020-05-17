export class AddArticleDto {
    name: string;
    categoryId: number;
    shortDescription: string;
    description: string;
    price: number;
    manufacturerId: number;
    materialId: number;

    features: {
        featureId: number;
        value: string;
    }[];
}