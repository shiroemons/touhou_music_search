# == Schema Information
#
# Table name: songs
#
#  id                               :uuid             not null, primary key
#  amazon_music_collection_name     :string           default(""), not null
#  amazon_music_collection_view_url :string           default(""), not null
#  amazon_music_track_name          :string           default(""), not null
#  amazon_music_track_view_url      :string           default(""), not null
#  amazon_store_collection_view_url :string           default(""), not null
#  artist_name                      :string           not null
#  artist_view_url                  :string           default(""), not null
#  artwork_url100                   :string           not null
#  artwork_url30                    :string           not null
#  artwork_url60                    :string           not null
#  collection_censored_name         :string           not null
#  collection_explicitness          :string           not null
#  collection_name                  :string           not null
#  collection_price                 :integer
#  collection_view_url              :text             not null
#  composer_name                    :string           default(""), not null
#  country                          :string           not null
#  currency                         :string           not null
#  disc_count                       :integer          not null
#  disc_number                      :integer          not null
#  has_lyrics                       :boolean          default(FALSE), not null
#  is_streamable                    :boolean          default(FALSE), not null
#  is_touhou                        :boolean          default(TRUE), not null
#  kind                             :string           not null
#  preview_url                      :string           default(""), not null
#  primary_genre_name               :string           not null
#  release_date                     :datetime         not null
#  spotify_collection_name          :string           default(""), not null
#  spotify_collection_view_url      :string           default(""), not null
#  spotify_track_name               :string           default(""), not null
#  spotify_track_view_url           :string           default(""), not null
#  track_censored_name              :string           not null
#  track_count                      :integer          not null
#  track_explicitness               :string           not null
#  track_name                       :string           not null
#  track_number                     :integer          not null
#  track_price                      :integer
#  track_time_millis                :integer          not null
#  track_view_url                   :text             not null
#  wrapper_type                     :string           not null
#  youtube_collection_name          :string           default(""), not null
#  youtube_collection_view_url      :string           default(""), not null
#  youtube_track_name               :string           default(""), not null
#  youtube_track_view_url           :string           default(""), not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  apple_artist_id                  :bigint           not null
#  apple_collection_id              :bigint           not null
#  apple_track_id                   :bigint           not null
#  discography_id                   :uuid             not null
#
# Indexes
#
#  index_songs_on_apple_artist_id      (apple_artist_id)
#  index_songs_on_apple_collection_id  (apple_collection_id)
#  index_songs_on_apple_track_id       (apple_track_id) UNIQUE
#  index_songs_on_discography_id       (discography_id)
#
# Foreign Keys
#
#  fk_rails_...  (discography_id => discographies.id)
#
class Song < ApplicationRecord
  has_one :odesli_song, dependent: :destroy

  has_many :songs_original_songs, dependent: :destroy
  has_many :original_songs, through: :songs_original_songs

  belongs_to :discography

  scope :includes_discography, -> { includes(:discography) }
  scope :touhou_doujin, -> { includes_discography.where(discographies: { record_label: '東方同人音楽流通' }) }

  scope :touhou, -> { where(is_touhou: true) }
  scope :not_touhou, -> { where(is_touhou: false) }
  scope :streamable, -> { where(is_streamable: true)}
  scope :not_streamable, -> { where(is_streamable: false)}
  scope :has_lyrics, -> { where(has_lyrics: true) }
  scope :has_not_lyrics, -> { where(has_lyrics: false) }
  scope :youtube_music, -> { where.not(youtube_track_name: '') }
  scope :spotify, -> { where.not(spotify_track_name: '') }
  scope :amazon_music, -> { where.not(amazon_music_track_name: '') }

  scope :touhou_music, lambda {
                         Song.includes(original_songs: :original)
                             .touhou_doujin
                             .order(release_date: :desc, track_number: :asc)
                       }

  # 例外の東方楽曲
  # 作曲者が ZUN または、あきやまうに ではない東方楽曲
  def self.exceptional_touhou_songs
    [
      1545504319, # 似非葬列指南	オカルティックドリーマー
      1545504320, # 似非葬列指南	カリソメキズナ
      1545504321, # 似非葬列指南	行方不明の。[葬列指南ver]
      1545504322, # 似非葬列指南	蒼い雨
      1545504323, # 似非葬列指南	グッドマイスター [葬列指南ver]
      1545504324, # 似非葬列指南	ゆりかごのなかで
      1545504325, # 似非葬列指南	拝啓、貴女の思い出
      1545504326, # 似非葬列指南	溶けた祈り
      1545503944, # 少女煉獄第伍巻	偶像ユートピア
      1545503945, # 少女煉獄第伍巻	奇麗な虹
      1545504336, # 少女煉獄第伍巻	明日も晴れますように[少女煉獄ver]
      1545504337, # 少女煉獄第伍巻	六分の一
      1545504338, # 少女煉獄第伍巻	水は流れ河となってゆく[少女煉獄ver]
      1545504339, # 少女煉獄第伍巻	私家版百鬼夜行絵巻[少女煉獄ver]
      1545504340, # 少女煉獄第伍巻	アイ
      1545504341, # 少女煉獄第伍巻	生花-seika-
      1503319966, # 東方猫鍵盤19	8月 恋のサマードレス
      1503319967, # 東方猫鍵盤19	9月 哀しき燐光のナイトバグ
      1503319968, # 東方猫鍵盤19	10月 五穀豊穣ロマンチカ
      1503319969, # 東方猫鍵盤19	11月 フォーリン・フォール
      1503319970, # 東方猫鍵盤19	12月 魔法使いはベルを鳴らす
      1545504273, # 東方猫鍵盤20	【0時】まよなかの国のアリス
      1545504274, # 東方猫鍵盤20	【2時】彼女は勤勉なる夜の女王
      1545504275, # 東方猫鍵盤20	【4時】誰も知らない、妖精たちの集い
      1545504456, # 東方猫鍵盤20	【6時】微睡みのロンド
      1545504457, # 東方猫鍵盤20	【8時】眠たげブレックファースト
      1545504458, # 東方猫鍵盤20	【10時】紅茶と焼き菓子のポルカ
      1545504459, # 東方猫鍵盤20	【12時】ドールハウスで昼食を
      1545504460, # 東方猫鍵盤20	【15時】うさぎたちの狂ったお茶会
      1545504461, # 東方猫鍵盤20	【16時】夕暮れフェアリーの家路
      1545504462, # 東方猫鍵盤20	【18時】空が優しく幕を下ろす
      1545504463, # 東方猫鍵盤20	【21時】パジャマパーティ狂騒曲
      1545504464, # 東方猫鍵盤20	【23時55分】今宵、ラストダンスを
    ]
  end
end
