ActiveAdmin.register User do
  permit_params :name, :email, :role, :password, :password_confirmation, :avatar

  filter :name
  filter :email
  filter :role, as: :select, collection: User.roles

  index do
    selectable_column
    id_column
    column :avatar do |user|
      image_tag user.avatar_url :avatar_header
    end
    column :name
    column :email
    column :role
  end

  show do
    attributes_table do
      row :avatar do |user|
        image_tag user.avatar_url :avatar_header
      end
      row :name
      row :email
      row :role
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
    end
  end

  form do |f|
    f.inputs "User infos" do
      f.input :name
      f.input :email
      f.input :role, as: :select, collection: User.roles.keys.to_a
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end

    f.inputs "Avatar" do
      f.input :avatar, label: "Update avatar", as: :file
    end

    f.actions
  end
end
