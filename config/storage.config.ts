export const StorageConfig = {

    photo: {
        destination: '../storage/photos/',
        urlPrefix: '/assets/photos', // putanja u linku kojom se dolazi do fotografija
        /*
        setujemo za koje vreme ce slika biti kesirana u mili sekundama
        */
        maxAge: 1000 * 60 * 60 * 24 * 7, // 7 dana
        maxSize: 3 * 1024 * 1024, // 3MB u bajtovima
        resize: {
            thumb: {
                width: 120,
                height: 100,
                directory: 'thumb/'
            },
            small: {
                width: 320,
                height: 240,
                directory: 'small/'
            }
        }
    }
};