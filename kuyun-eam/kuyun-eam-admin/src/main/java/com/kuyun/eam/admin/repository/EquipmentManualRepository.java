package com.kuyun.eam.admin.repository;

import com.kuyun.eam.admin.model.EquipmentManual;
import com.kuyun.eam.admin.model.MaintainKnowledge;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by user on 2017-10-27.
 */
@Repository
public interface EquipmentManualRepository extends ElasticsearchRepository<EquipmentManual, String> {
    Page<EquipmentManual> findByTitleOrTagOrContentOrderByCreateTimeDesc(String title, String tag, String content, Pageable pageable);

}
