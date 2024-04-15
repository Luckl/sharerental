
export type FilterType = "number" | "choice" | "boolean";

export type Filter = {
    name: string;
    key: string;
    type: FilterType;
    suffix?: string;
}

export type FilterState = {
    filters: Filter[];
}

export const useFilterStore = defineStore({
    id: 'filterTranslationStore',
    state: () => ({
        filters: [
            {
                name: 'Prijs per dag',
                key: "price_24h",
                type: "number"
            },
            {
                name: 'Merk',
                key: "brand",
                type: "choice"
            },
            {
                name: 'Categorie',
                key: "category",
                type: "choice"
            },
            {
                name: 'Brandstof',
                key: "fuel_type",
                type: "choice"
            },
            {
                name: 'Materiaal',
                key: "material_type",
                type: "choice"
            },
            {
                name: 'Maximale druk in bars',
                key: "maximum_pressure_bars",
                type: "choice",
                suffix: "bar"
            },
            {
                name: 'Vermogen (PK)',
                key: "maximum_horse_power",
                type: "choice",
                suffix: "PK"
            },
            {
                name: 'Vereiste spanning',
                key: "required_power_voltage_volt",
                type: "choice",
                suffix: "V"
            },
            {
                name: 'Werkbreedte',
                key: "work_width_meters",
            },
            {
                name: 'Stofzuiger aansluiting',
                key: "vacuum_attachment_possible",
                type: "boolean"
            },
            {
                name: 'Capaciteit',
                key: "capacity_liters",
            },
            {
                name: 'Hoogte',
                key: "item_height",
            },
            {
                name: 'Breedte',
                key: "item_width",
            },
            {
                name: 'Lengte',
                key: "item_length",
            },
            {
                name: 'Vermogen (W)',
                key: "power_watt",
            },
            {
                name: 'Maximale oppervlakte',
                key: "maximum_surface_square_meters",
            },
            {
                name: 'Levering mogelijk',
                key: "delivery_possible",
                type: "boolean"
            },
            {
                name: 'Leveringsprijs',
                key: "delivery_price",
                type: "number"
            },
            {
                name: 'Bereik',
                key: "reach_meters",
            },
            {
                name: 'Draagvermogen',
                key: "carrying_weight_kilograms",
            },
            {
                name: 'Maximale werkhoogte',
                key: "maximum_work_height_meters",
            },
            {
                name: 'Intrinsiek gewicht',
                key: "intrinsic_weight_kilograms",
            },
        ]
    } as FilterState),
    getters: {
        getFilters(state: FilterState) {
            return state.filters;
        }
    }
})