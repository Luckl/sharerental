import {
    Configuration,
    ContactFormApi,
    UserApi, type UserUserTypeEnum
} from '~/schemas/openapi/contactForm';

import type {
    ContactForm
} from '~/schemas/openapi/contactForm';

export type {
    ContactForm
}

class ContactFormClient {
    private contactFormApi: ContactFormApi;
    private userApi: UserApi;

    constructor(configuration: Configuration) {
        this.contactFormApi = new ContactFormApi(configuration);
        this.userApi = new UserApi(configuration);
    }

    sendContactForm(contactForm: ContactForm) {
        return this.contactFormApi.sendContactForm({
            contactForm: contactForm
        })
    }

    registerUser(userType: UserUserTypeEnum) {
        return this.userApi.registerUser({
            user: {
                userType: userType
            }
        })
    }
}

export default ContactFormClient
