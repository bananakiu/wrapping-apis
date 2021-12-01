class Image < ApplicationRecord
    has_one_attached :image_to_analyze
    include Rails.application.routes.url_helpers

    def attachment_url
        if self.image_to_analyze.attached?
            # rails_blob_path(self.image_to_analyze, disposition: "inline", only_path: true)
            rails_blob_path(self.image_to_analyze, disposition: "download", only_path: true)
            # rails_blob_path(self.image_to_analyze, disposition: "attachment", only_path: true)
        else
            nil
        end
    end

    def image_on_disk
        ActiveStorage::Blob.service.send(:path_for, self.image_to_analyze)
        # ActiveStorage::Blob.service.path_for(self.image_to_analyze.attachment)
        # ActiveStorage::Blob.service.path_for(self.image_to_analyze)
    end
end
