import {
    Configuration,
    ContactFormApi,
} from '~/schemas/openapi/contactForm';

import type {
    ContactForm
} from '~/schemas/openapi/contactForm';

export type {
    ContactForm
}

class ContactFormClient {
    private contactFormApi: ContactFormApi;

    constructor(configuration: Configuration) {
        this.contactFormApi = new ContactFormApi(configuration);
    }

    sendContactForm(contactForm: ContactForm) {
        return this.contactFormApi.sendContactForm({
            contactForm: contactForm
        })
    }
}

export default ContactFormClient
