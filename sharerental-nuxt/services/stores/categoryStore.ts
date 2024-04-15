
export type Category = {
    name: string;
    page: string;
    image: string;
}

export type CategoryState = {
    categories: Category[];
}

export const useCategoryStore = defineStore({
    id: 'categoryStore',
    state: () => ({
        categories: [
            {
                name: 'Stijgers, trappen en hoogwerkers',
                page: "stijgers-trappen-hoogwerkers",
                image: 'categories/stijgers-trappen-hoogwerkers.jpg'
            },
            {
                name: 'Luchtdrukgereedschap',
                page: "luchtdrukgereedschap",
                image: 'categories/Luchtdrukgereedschap.jpg'
            },
            {
                name: 'Electrisch gereedschap',
                page: "electrisch-gereedschap",
                image: 'categories/electrisch-gereedschap-3.jpg'
            },
            {
                name: 'Betonbewerking',
                page: "betonbewerking",
                image: 'categories/Betonbewerking.jpg'
            },
            {
                name: 'Grondverzetters, bouwmachines en tuinmateriaal',
                page: "grondverzetters-bouwmachines-tuinmateriaal",
                image: 'categories/grondverzetters-bouwmachines-tuinmateriaal.jpg'
            },
            {
                name: 'Evenementen',
                page: "evenementen",
                image: 'categories/Evenementen.jpg'
            },
            {
                name: 'Hef-hijswerktuigen',
                page: "hef-hijswerktuigen",
                image: 'categories/hef-en-hijswerktuigen.jpg'
            },
            {
                name: 'Verwarmen, drogen en reinigen',
                page: "verwarmen-drogen-reinigen",
                image: 'categories/verwarmen-drogen-reiningen.jpg'
            },
            {
                name: 'Transport',
                page: "transport",
                image: 'categories/transport.jpg'
            }
        ],
    }),
})