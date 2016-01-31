ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
      # span class: "blank_slate" do
        # span I18n.t("active_admin.dashboard_welcome.welcome")
        # small I18n.t("active_admin.dashboard_welcome.call_to_action")
      # end
    # end
    
    #1st Column
    columns do 
      
      # Recent 5 Requests
      column do
        panel "Recent Requests" do
          table_for Request.order("created_at DESC").limit(5).map do
            column :id
            column :title
            column :budget  
            column :city
            column :organiser
            column :cancel
            column :vendor_select
          end
        end
      end
            
      # Recent 5 Awarded Request
      column do
        panel "Recent Awarded Requests" do
          table_for Request.where(vendor_select: true).order("created_at DESC").limit(5).map do
            column :id
            column :title
            column :budget
            column :city
            column :organiser
            column :cancel
            column :vendor_select
          end
        end
      end
      
    end
    
    #2nd Column    
    columns do
      
      # Recent 5 Organisers
      column do
        panel "Recent Organisers" do
          table_for Organiser.order("created_at DESC").limit(5).map do
            column :id
            column :email
            column :username
            column "Name", :organiser do |name|
              full_name_object(name)
            end
            column "Confirmed", :organisers do |organiser|
              if (!organiser.confirmed_at.nil?)
                span :class=>"status_tag yes" do
                  TRUE
                end
              else
                span :class=>"status_tag no" do
                  FALSE
                end
              end
            end
            column :created_at
          end
        end
      end
      
      # Recent 5 Vendors
      column do
        panel "Recent Vendors" do
          table_for Vendor.order("created_at DESC").limit(5).map do
            column :id
            column :email
            column :username
            column "Name", :vendor do |name|
              full_name_object(name)
            end
            column "Confirmed", :vendors do |vendor|
              if (!vendor.confirmed_at.nil?)
                span :class=>"status_tag yes" do
                  TRUE
                end
              else
                span :class=>"status_tag no" do
                  FALSE
                end
              end
            end
            column :created_at
          end
        end
      end
      
    end
    
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
