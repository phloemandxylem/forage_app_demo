class ChargesController < ApplicationController

      def downgrade
         #Called from the apps/views/devise/registrations/edit.html.erb button

         #Add stripe code to refund the amount paid here id desired
         current_user.standard! #Downgrade user to standard
         current_user.wikis.each { |wiki| wiki.update_attribute(:private, false) }
         flash[:notice] = "Your account was downgraded.  All private Wikis are now public."
         redirect_to root_path

         #Alternatite ways to do things
         #current_user.update_attributes(role: 'standard')
         #current_user.wikis.where(private: true).update_all(private: false)
         #redirect_to edit_user_registration_path
       end

        def new
          @stripe_btn_data = {
            key: "#{ Rails.configuration.stripe[:publishable_key] }",
            description: "Upgraded Membership - #{current_user.name}",
            amount: Amount.default,
          }
        end

        def create
          # Creates a Stripe Customer object, for associating
          # with the charge
          customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
          )

          # Where the real magic happens
          charge = Stripe::Charge.create(
            customer: customer.id, # Note -- this is NOT the user_id in your app
            amount: Amount.default,
            description: " Upgraded Membership - #{current_user.email}",
            currency: 'usd'
          )

          #Update the user role
          current_user.premium!

          flash[:notice] = "You're account is now updated, #{current_user.email}!"
          redirect_to edit_user_registration_path # or wherever

          # Stripe will send back CardErrors, with friendly messages
          # when something goes wrong.
          # This `rescue block` catches and displays those errors.
          rescue Stripe::CardError => e
            flash[:error] = e.message
            redirect_to new_charge_path
        end

     end
