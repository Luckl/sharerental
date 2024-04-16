
export enum FilterType {
    Number = "number",
    Choice = "choice",
    Boolean = "boolean"
}
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
                type: "choice"
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
                type: "choice"
            },
            {
                name: 'Stofzuiger aansluiting',
                key: "vacuum_attachment_possible",
                type: "boolean"
            },
            {
                name: 'Capaciteit',
                key: "capacity_liters",
                type: "choice",
                suffix: "L"
            },
            {
                name: 'Hoogte',
                key: "item_height",
                type: "choice",
                suffix: "m"
            },
            {
                name: 'Breedte',
                key: "item_width",
                type: "choice",
                suffix: "m"
            },
            {
                name: 'Lengte',
                key: "item_length",
                type: "choice",
                suffix: "m"
            },
            {
                name: 'Vermogen (W)',
                key: "power_watt",
                type: "choice",
                suffix: "W"
            },
            {
                name: 'Maximale oppervlakte',
                key: "maximum_surface_square_meters",
                type: "choice",
                suffix: "m²"
            },
            {
                name: 'Levering mogelijk',
                key: "delivery_possible",
                type: "boolean"
            },
            {
                name: 'Leveringsprijs',
                key: "delivery_price",
                type: "choice"
            },
            {
                name: 'Bereik',
                key: "reach_meters",
                type: "choice",
                suffix: "m"
            },
            {
                name: 'Draagvermogen',
                key: "carrying_weight_kilograms",
                type: "choice",
                suffix: "kg"
            },
            {
                name: 'Maximale werkhoogte',
                key: "maximum_work_height_meters",
                type: "choice",
                suffix: "m"
            },
            {
                name: 'Intrinsiek gewicht',
                key: "intrinsic_weight_kilograms",
                type: "choice",
                suffix: "kg"
            },
        ]
    } as FilterState),
    getters: {
        getFilters(state: FilterState) {
            return state.filters;
        }
    }
})