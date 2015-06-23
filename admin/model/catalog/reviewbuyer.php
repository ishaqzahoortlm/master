<?php
class ModelCatalogReviewbuyer extends Model {
	

	public function editReview($review_id, $data) {
		
		$this->db->query("UPDATE " . DB_PREFIX . "ms_order_buyer_reviews SET  text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "' WHERE review_id = '" . (int)$review_id . "'");

	}

	public function deleteReview($review_id) {
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "ms_order_buyer_reviews WHERE review_id = '" . (int)$review_id . "'");

		
	}

	public function getReview($review_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "ms_order_buyer_reviews r WHERE r.review_id = '" . (int)$review_id . "'");

		return $query->row;
	}

	public function getReviews($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "ms_order_buyer_reviews r  WHERE  1=1 ";

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND r.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(r.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$sort_data = array(
			'r.rating',
			'r.status',
			'r.date_added'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY r.date_added";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getTotalReviews($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "ms_order_buyer_reviews r  WHERE 1=1 ";

		

		if (!empty($data['filter_status'])) {
			$sql .= " AND r.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(r.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getTotalReviewsAwaitingApproval() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "ms_order_buyer_reviews WHERE status = '0'");

		return $query->row['total'];
	}
        
        public function getSellerInfo($id) {
		$query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "ms_seller WHERE seller_id = '".$id."'");
                return $query->row;
	}
}