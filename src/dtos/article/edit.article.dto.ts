export class EditArticleDto {
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
    }[] | null; // ako se setuje null, ne editujemo featur-e
}