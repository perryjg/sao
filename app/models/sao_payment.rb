class SaoPayment < ActiveRecord::Base
	scope :after_date,  lambda { |date| where( 'transaction_date > ?', date ) }
	scope :before_date, lambda { |date| where( 'transaction_date < ?', date ) }
	scope :on_date,     lambda { |date| where( 'transaction_date = ?', date ) }
	
	scope :vendor_exact,       lambda { |vendor| where( 'vendor_name = ?',    vendor) }
	scope :vendor_starts_with, lambda { |vendor| where( 'vendor_name like ?', vendor + '%' ) }
	scope :vendor_includes,    lambda { |vendor| where( 'vendor_name like ?', '%' + vendor + '%' ) }
	
	scope :agency_exact,       lambda { |agency| where( 'agency_name = ?',    agency) }
	scope :agency_starts_with, lambda { |agency| where( 'agency_name like ?', agency + '%' ) }
	scope :agency_includes,    lambda { |agency| where( 'agency_name like ?', '%' + agency + '%' ) }
	scope :agency_code,        lambda { |code| where( 'agency_code = ?', code ) }
	
	scope :class_exact,       lambda { |c| where( 'class_description = ?',    c ) }
	scope :class_starts_with, lambda { |c| where( 'class_description like ?', c + '%' ) }
	scope :class_includes,    lambda { |c| where( 'class_description like ?', '%' + c + '%' ) }
	scope :class_code,        lambda { |code| where( 'class_code = ?', code ) }

	def self.search( params )
		payments = scoped
		payments = payments.vendor_includes( params[:vendor] ) if params[:vendor] =~ /\w/
		payment  = payments.agency_includes( params[:agency] ) if params[:agency] =~ /\w/
		payment  = payments.class_includes(  params[:class ] ) if params[:class ] =~ /\w/
		payments = payments.on_date(     params[:on_date    ] ) if params[:on_date    ] =~ /\d{4}-\d{2}-\d{2}/
		payments = payments.after_date(  params[:after_date ] ) if params[:after_date ] =~ /\d{4}-\d{2}-\d{2}/
		payments = payments.before_date( params[:before_date] ) if params[:before_date] =~ /\d{4}-\d{2}-\d{2}/
		payments
	end
	
	# Summary methods
	def self.sum_by_agency
		sum( :amount, :group => :agency_name ).map { |a| { :agency => a[0], :amount => a[1].to_f } }
	end
	
	def self.sum_by_class
		sum( :amount, :group => :class_description ).map { |c| { :class => c[0], :amount => c[1].to_f } }
	end
	
	def self.sum_by_vendor
		sum( :amount, :group => :vendor_name ).map { |v| { :vendor => v[0], :amount => v[1].to_f } }
	end
	
	# list methods
	def self.agency_list
		select( 'distinct agency_code, agency_name' ).order( 'agency_name' ).map { |a| {:agency_code => a.agency_code, :agency_name => a.agency_name } }
	end

	def self.class_list
		select( 'distinct class_code, class_description as class_name' ).order( 'class_name' ).map { |a| {:class_code => a.class_code, :class_name => a.class_name } }
	end

	def self.vendor_list
		select( 'distinct vendor_name' ).order( 'vendor_name' ).map { |a|  a.vendor }
	end
end

