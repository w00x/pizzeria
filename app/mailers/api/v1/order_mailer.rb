class Api::V1::OrderMailer < ApplicationMailer
	def new_order order
		@order = order

		# Para que no se agrupen los mails
		headers['X-Entity-Ref-ID'] = SecureRandom.urlsafe_base64.to_s

		mail(from: "Pizzeria <noreply@amason.cl>", to: @order.store.email, subject: "Nueva orden")
	end
end
