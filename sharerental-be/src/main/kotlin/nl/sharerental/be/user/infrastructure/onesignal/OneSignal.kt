package nl.sharerental.be.user.infrastructure.onesignal

import nl.sharerental.be.user.User


interface OneSignal {
    fun createNewWebUserInOneSignal(user: User, subscribedToNews: Boolean)
    fun sendWelcomeEmail(user: User)
}