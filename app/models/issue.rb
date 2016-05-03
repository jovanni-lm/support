class Issue < ActiveRecord::Base
  validates :name, :email, :body, :subject, presence: true
  before_create :set_task_id, :default_status
  after_create :send_issue_email

  validates_email_format_of :email
  has_paper_trail only: [:staff_id, :status_id]
  has_many :replies, dependent: :destroy
  accepts_nested_attributes_for :replies,
                                allow_destroy: true,
                                reject_if: :all_blank
  belongs_to :staff
  belongs_to :status
  self.per_page = 10

  filterrific available_filters: [
    :search_query,
    :with_status_id
  ]

  scope :search_query, lambda { |query|
    return nil if query.blank?

    terms = query.downcase.split(/\s+/)

    terms = terms.map do |e|
      (e.tr('*', '%') + '%').gsub(/%+/, '%')
    end

    num_or_conds = 4

    where(
      terms.map do
        "(LOWER(issues.name) LIKE ? OR LOWER(issues.subject) LIKE ?
          OR LOWER(issues.department) LIKE ? OR LOWER(issues.body) LIKE ?)"
      end.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :with_status_id, lambda { |status_id|
    where(status_id: status_id)
  }

  def send_issue_email
    CustomerMailer.new_issue_email(self).deliver_now
  end

  def set_task_id
    self.task_id = SecureRandom.issue_unique_identifier
  end

  def to_param
    task_id
  end

  def default_status
    self.status_id = Status.first.id
  end
end
