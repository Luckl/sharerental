import {
    Configuration,
    ContactFormApi,
    ZipcodeApi,
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
    private zipcodeApi: ZipcodeApi;

    constructor(configuration: Configuration) {
        this.contactFormApi = new ContactFormApi(configuration);
        this.userApi = new UserApi(configuration);
        this.zipcodeApi = new ZipcodeApi(configuration);
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

    zipcode(zipcode: string, houseNumber: string) {
        return this.zipcodeApi.getAddressByZipcode({
            zipcode: zipcode,
            houseNumber: houseNumber
        })
    }
}

export default ContactFormClient
