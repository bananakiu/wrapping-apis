class Image < ApplicationRecord
    has_one_attached :image_to_analyze

    # def image_on_disk
    #     ActiveStorage::Blob.service.send(:path_for, image_to_analyze.key)
    # end
end
